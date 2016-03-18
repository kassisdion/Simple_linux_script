#! bin/sh

echo "installing Pithon and Pip..."
sudo apt-get install python-pip python-dev build-essential
sudo -H pip install --upgrade pip

echo "Installing Flask..."
sudo -H pip install Flask

echo "Installing Flask-script"
sudo -H pip install Flask-Assets

echo "Installing Flask-SqlAlchemy"
sudo -H pip install Flask-SqlAlchemy
