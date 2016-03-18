#include <stdio.h> //fprintf(), fscanf(), fclosef()
#include <string.h>
#include <stdlib.h>
#include <ctype.h> //isdigit()
#include <dirent.h> //readdir(), closedir()

/*
 *return 1 is str is made with only digit
 *return 0 is str contain other characters than [0-9]
 */
 static int check_if_number(char *str)
 {
  for (int i=0; str[i] != '\0'; i++)
  {
    if (!isdigit(str[i]))
    {
      return 0;
    }
  }
  return 1;
}

/*
 * return the process name from a given process dir
 */
static char* get_cmd_name(struct dirent *entry) {

  char path[1024];

  strcpy(path, "/proc/");
  strcat(path, entry->d_name);
  strcat(path, "/comm");

  FILE *fp = fopen(path, "r");
  char read_buf[1024];
  if (fp != NULL)
  {
    fscanf(fp, "%s", read_buf);
    fclose(fp);
  }
  
  char *process_name = malloc(strlen(read_buf));
  strcpy(process_name, read_buf);
  
  return process_name;
}

/*
 * return the "The controlling terminal of the process" from a given process dir
 */
 static int get_controlling_terminal(struct dirent *entry) {
  char path[1024];

  strcpy(path,"/proc/");
  strcat(path,entry->d_name);
  strcat(path,"/stat");

  FILE *fp = fopen(path, "r");

  char *line;
  size_t len = 0;
  getline(&line,&len,fp);
 
  char comm[10],state;
  unsigned int flags;
  int pid,ppid,pgrp,session,tty_nr,tpgid;
  unsigned long minflt,cminflt,majflt,cmajflt,utime,stime;
  unsigned long long starttime;
  long cutime,cstime,priority,nice,num_threads,itreavalue;
  sscanf(line,"%d %s %c %d %d %d %d %d %u %lu %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld  %ld %llu",
    &pid, comm, &state, &ppid, &pgrp, &session, &tty_nr,
    &tpgid, &flags, &minflt, &cminflt, &majflt,&cmajflt,&utime,
    &stime, &cutime, &cstime, &priority, &nice, &num_threads, &itreavalue,
    &starttime);

  return tty_nr;
 }

/*
 * Main function
 */
static void my_ls()
{
  DIR *dirp;
  dirp = opendir("/proc/");
  if (dirp == NULL)
  {
    perror ("Fail");
    exit(0);
  } 

  struct dirent *entry;
  while ((entry = readdir(dirp)) != NULL)
  {
    if (check_if_number(entry->d_name))
    { 
      char *cmd_name = get_cmd_name(entry);
      int tty_nr = get_controlling_terminal(entry);

      fprintf(stdout,"%s %d %s\n",
        entry->d_name, /*PID*/
        tty_nr, /*TTY*/
        cmd_name /*CMD*/);

      free(cmd_name);
    }
  } 
  closedir(dirp);
}

int main(int argc, char *argv[])
{
  my_ls(); 
  return 0;
}
