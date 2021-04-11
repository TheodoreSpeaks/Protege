#!/usr/bin/env python3
import json
import numpy as np
from sklearn.cluster import spectral_clustering
from flask import Flask, jsonify, request
from MinHash import get_sig, compare

app = Flask(__name__)
names = ["teddy", "jake", "drew", "chuck"]

convo_template = {'id': -1,
          'name': "",
          'convo': "",
          'summary': "here is a short summary",
          'group': -1
            }

group_template = {'id': -1,
          'convos': []
          }
groups=[]
convos =[] 
'''{'id': 0,
          'convo': "HERE IS A LONG CONVERSATION",
          'summary': "here is a short summary"} ,
        ]
'''
def hash_convos():
    global convos
    for i in range(len(convos)):
        convos[i]["sig"] = get_sig(convos[i]['convo'])

def group():
    print("grouping conversations")
    comp_mat = np.zeros((len(convos), len(convos)))
    for i in range(len(convos)):
        for j in range(len(convos)):
            comp_mat[i,j] = compare(convos[i]['sig'], convos[j]['sig'])

    n_clusters = min(len(convos), 4)
    clusters = spectral_clustering(comp_mat, n_clusters=n_clusters)
    print("adj mat:", comp_mat)
    print("cluster:", clusters)
    for i in range(n_clusters):
        new_group = group_template.copy()
        new_group['id'] = i
        for j in range(len(convos)):
            if clusters[j] == new_group['id']:
                res = next((sub for sub in convos if sub['id'] == j), None)
                if res is None: 
                    continue
                new_group['convos'].append(res)
        groups.append(new_group)
    '''
    group_counter = 0
    for i in range(len(convos)):
        base_convo = convos[i]
        if base_convo['group'] != -1:
            continue;
        base_convo['group'] = group_counter
        group_countr+=1
        for j in range(len(convos)):
            if comp_mat[i,j] > 
    '''

def save_to_file(convo):
    with open("preset_convos", 'a') as f:
        f.write(convo)
        f.write("\n===END_CONVO==\n")
        print("wrote file")

def load_convos():
    with open("preset_convos", 'r') as f:
        text_convos = f.read()
    text_convos = text_convos.split("===END_CONVO==")
    for text_convo in text_convos:
        createConvo(text_convo)

@app.route('/add_convo', methods=['GET'])
def createConvo():  
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    if 'convo' in request.args:
        convo = request.args['convo']
    else:
        return "Error: No id field provided. Please specify an id."

    save_to_file(convo)

    return createConvo(convo)

def createConvo(convo):  

    convo_template['id'] += 1
    new_convo = convo_template.copy()
    new_convo['convo'] = convo
    new_convo['name'] = names[new_convo['id']%len(names)]
    new_convo["sig"] = get_sig(new_convo['convo'])
    convos.append(new_convo)
    group()
#    print(new_convo)
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

@app.route('/get_all_convo', methods=['GET'])
def getConvos():
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    return jsonify(convos)

@app.route('/get_groups', methods=['GET'])
def getGroups():
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
#    print(groups)
    group_dict = {"groups" : groups}
    return jsonify(group_dict)
#    print("json:", json[68930:68935]) 


load_convos()
print(convos)
group()


if __name__ == '__main__':
    app.run()
