NAME= my_ps

CC= gcc

RM= rm -f

SRC= my_ps.c

OBJ= $(SRC:.c=.o)

CFLAGS= -g -Wall

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) -o $(NAME) $(CFLAGS) $(OBJ)

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all
