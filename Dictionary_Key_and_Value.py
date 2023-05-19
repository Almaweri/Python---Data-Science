d_1 = {'key_1': 'value_1',
       'key_2': 1,
       'key_3': 1.832,
       'key_4': False,
       'key_5': [1,2,3],
       'key_6': {'inner_key' : 10}}

print(d_1)
print(d_1['key_1'])
print(d_1['key_6'])

#updating the first 3 keys with new values.

d_1['key_1'] = 'Maged Almaweri'
d_1['key_2'] = '05/18/2023'
d_1['key_3'] = 'I can do it'

print(d_1['key_1'])
print(d_1['key_2'])
print(d_1['key_3'])
