#!/usr/bin/python
import requests
import json
import pprint

class Api():
	SERVER_URL = 'http://127.0.0.1:5000/'

	def __init__(self):
		pass


	def add_entry(self, firstname, lastname, address, phone_number):
		payload		= {	'firstname': firstname,
						'lastname': lastname,
						'address': address,
						'phone_number': phone_number}
		json_data 	= json.dumps(payload)
		headers 	= {'content-type': 'application/json'}
		
		response 	= requests.post(self.SERVER_URL + 'add_entry', data=json_data, headers=headers)
		return response


	def update_entry(self, object_id, firstname, lastname, address, phone_number):
		payload		= { 'id' 			: object_id,
						'firstname'		: firstname,
						'lastname'      : lastname,
						'address'       : address,
						'phone_number'	: phone_number }
		json_data 	= json.dumps(payload)
		headers 	= {'content-type': 'application/json'}

		response 	= requests.put(self.SERVER_URL + 'update_entry', data=json_data, headers=headers)
		return response


	def delete_entry(self, object_id):
		payload		= {	'id' : object_id }
		json_data 	= json.dumps(payload)
		headers 	= {'content-type': 'application/json'}

		response 	= requests.delete(self.SERVER_URL + 'delete_entry', data=json_data, headers=headers)
		return response


	def lookup_entry(self, id):
		payload		= {	'id' : id }
		json_data 	= json.dumps(payload)
		headers 	= {'content-type': 'application/json'}

		response 	= requests.get(self.SERVER_URL + 'lookup_entry', data=json_data, headers=headers)
		return response		


	def list_entries(self):
		payload		= {	}
		json_data 	= json.dumps(payload)
		headers 	= {'content-type': 'application/json'}

		response 	= requests.get(self.SERVER_URL + 'entries', data=json_data, headers=headers)
		return response

class Phonebook_client():
	def __init__(self):
		self.api = Api()


	def run(self):
		choice = 0
		while choice != 6:
			self.print_menu()
			choice = int(input("Choose an action (1-6): "))
			if choice == 1:
				self.list_entries()
			elif choice == 2:
				self.lookup_entry()
			elif choice == 3:
				self.delete_entry()
			elif choice == 4:
				self.update_entry()
			elif choice == 5:
				self.add_entry()
			elif choice != 6:
				self.print_menu()


	def print_menu(self):
		print '1. list_entries'
		print '2. lookup_entry'
		print '3. delete_entry'
		print '4. update_entry'
		print '5. add_entry'
		print '6. quit'
		print

	def add_entry(self):
		firstname		= raw_input('firstname: ')
		lastname		= raw_input('lastname: ')
		country 		= raw_input('country: ')
		phone_number	= raw_input('phone_number: ')

		add_entry_reponse = self.api.add_entry(firstname, lastname, country, phone_number).json()
		print 'Your contact has been added :'
		print pprint.pprint(add_entry_reponse), '\n'

	def update_entry(self):
		object_id		= raw_input('User_id: ')
		firstname		= raw_input('firstname: ')
		lastname		= raw_input('lastname: ')
		country 		= raw_input('country: ')
		phone_number	= raw_input('phone_number: ')

		update_entry_response = self.api.update_entry(User_id, firstname, lastname, country, phone_number).json()
		print pprint.pprint(update_entry_response), '\n'


	def delete_entry(selraw_inputf):
		object_id = raw_input('User_id: ')

		delete_entry_response = self.api.delete_entry(object_id).json()
		print pprint.pprint(delete_entry_response)

	def lookup_entry(self):
		object_id = raw_input('User_id: ')
		
		lookup_entry_response = self.api.lookup_entry(object_id).json()
		print pprint.pprint(lookup_entry_response), '\n'


	def list_entries(self):
		list_entries_response = self.api.list_entries().json()
		print pprint.pprint(list_entries_response), '\phone_number'


if __name__ == '__main__':	
	Phonebook_client().run()