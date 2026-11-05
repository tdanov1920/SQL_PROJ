import requests
import json

base_url = "jsonplaceholder.typicode.com"

def get_json():
    url = f"https://{base_url}/users"
    response = requests.get(url)

    if response.status_code == 200:
        users_data = response.json()
        #print(users_data)
        user_dict = []

        for user in users_data: 
            user_info = {
                print(f"{user['name']}"),
                print(f"{user['username']}"),
                print(f"{user['email']}"),
                print(f"{user['company']['name']}")}

            user_dict.append(user_info)

    else:
        print(f"Failed to retrieve data. Status code: {response.status_code}")
        return


reading = get_json()







