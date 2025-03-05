import requests
from bs4 import BeautifulSoup

def scrape_scholarships(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')

    scholarships = []

    # Example: Find all scholarship entries
    for entry in soup.find_all('div', class_='scholarship-entry'):
        title = entry.find('h2').text
        amount = entry.find('span', class_='amount').text
        deadline = entry.find('span', class_='deadline').text
        description = entry.find('p', class_='description').text

        scholarships.append({
            'title': title,
            'amount': amount,
            'deadline': deadline,
            'description': description
        })

    return scholarships

url = 'https://example.com/scholarships'
scholarships = scrape_scholarships(url)
print(scholarships)