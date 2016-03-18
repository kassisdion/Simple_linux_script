from flask_sqlalchemy import SQLAlchemy
from phonebook_server import app

db = SQLAlchemy(app)

class Contact(db.Model):
    id              = db.Column(db.Integer,primary_key=True)
    firstname       = db.Column(db.String)
    lastname        = db.Column(db.String)
    address         = db.Column(db.String)
    phone_number    = db.Column(db.String)


    def __init__(self, firstname, lastname, address, phone_number):
        self.firstname      = firstname
        self.lastname       = lastname
        self.address        = address
        self.phone_number   = phone_number

    @property
    def serialize(self):
        """Return object data in easily serializeable format"""
        return {
            'id'            : self.id,
            'firstname'     : self.firstname,
            'lastname'      : self.lastname,
            'address'       : self.address,
            'phone_number'  : self.phone_number
        }