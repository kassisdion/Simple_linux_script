#!/usr/bin/python
from flask import Flask, request, jsonify
import logging
from logging.handlers import RotatingFileHandler

# create our little application :)
app = Flask(__name__)
app.debug = True
app.config['SECRET_KEY'] = 'F34TF$($e34D';
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///phonebook_server.db'


from models import *
@app.route('/add_entry', methods=['POST'])
def add_entry():
	app.logger.info(request)
	app.logger.info(request.get_json)

	json_param = request.get_json()

	#TODO check if the json is correct
	new_contact = Contact(
		json_param['firstname'],
		json_param['lastname'],
		json_param['address'],
		json_param['phone_number'])

	db.session.add(new_contact)
	db.session.commit()

	return jsonify(new_contact.serialize)


@app.route('/update_entry', methods=['PUT'])
def update_entry():
	app.logger.info(request)
	app.logger.info(request.get_json)

	#TODO check if the json is correct
	json_param  = request.get_json()
	id_param    = json_param['id']
	
	#TODO check of contact exist (could have been deleted)
	contact     = Contact.query.filter_by(id=id_param).first()

	contact.firstname 		= json_param['firstname']
	contact.lastname 		= json_param['lastname']
	contact.address 		= json_param['address']
	contact.phone_number	= json_param['phone_number']

	db.session.commit()

	return jsonify(contact.serialize)


@app.route('/delete_entry', methods=['DELETE'])
def delete_entry():
	app.logger.info(request)
	app.logger.info(request.get_json)
	
	#TODO check if the json is correct
	json_param = request.get_json()
	id_param   = json_param['id']
	
	Contact.query.filter_by(id=id_param).delete()

	db.session.commit()

	return jsonify({'Success' : True})


@app.route('/lookup_entry', methods=['GET'])
def lookup_entry():
	app.logger.info(request)
	app.logger.info(request.get_json)

	#TODO check if the json is correct
	json_param  = request.get_json()
	id_param    = json_param['id']

	#TODO check of contact exist (could have been deleted)
	contact     = Contact.query.filter_by(id=id_param).first()

	return jsonify(contact.serialize)

@app.route('/entries', methods=['GET'])
def entries():
	app.logger.info(request)
	app.logger.info(request.get_json)
	return jsonify(json_list=[i.serialize for i in Contact.query.all()])


if __name__ == '__main__':
	handler = RotatingFileHandler('foo.log', maxBytes=10000, backupCount=1)
	handler.setLevel(logging.INFO)
	app.logger.addHandler(handler)
	app.run()