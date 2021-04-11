#!/usr/bin/env python3
from flask import Flask, jsonify, request

convo_template = {'id': 0,
          'convo': "HERE IS A LONG CONVERSATION",
          'summary': "here is a short summary"}

convos =[{'id': 0,
          'convo': "HERE IS A LONG CONVERSATION",
          'summary': "here is a short summary"} ,
        ]
app = Flask(__name__)

@app.route('/save_convo', methods=['GET'])
def createConvo():  
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    if 'convo' in request.args:
        convo = request.args['convo']
    else:
        return "Error: No id field provided. Please specify an id."
    convo_template['id'] += 1
    new_convo = convo_template.copy()
    new_convo['convo'] = convo
    convos.append(new_convo)
    print(convos)
    return 'convo added at ' + str(new_convo['id'])

@app.route('/get_convo', methods=['GET'])
def getConvo():
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    if 'id' in request.args:
        id = int(request.args['id'])
    else:
        return "Error: No id field provided. Please specify an id."

    if id < len(convos):
        res = next((sub for sub in convos if sub['id'] == id), None)
        if res is not None:
            return jsonify(res)
    return "Error: No invalid id provided. Please specify a valid id."

if __name__ == '__main__':
    app.run()
