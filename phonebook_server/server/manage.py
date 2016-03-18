#!/usr/bin/env python
from flask.ext.script import Manager , Shell, Server
from phonebook_server import app

manager = Manager(app)
manager.add_command("runserver", Server())
manager.add_command("shell", Shell())

@manager.command
def createdb():
    from phonebook_server.models import db
    db.create_all()

manager.run()