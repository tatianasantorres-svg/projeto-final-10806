# scraper.py - Caixa Negra de Web Scraping (Não alterar)
import urllib.request
import re
import sys

try:
    # Acede a um site de testes de scraping
    url = 'http://quotes.toscrape.com/'
    html = urllib.request.urlopen(url).read().decode('utf-8')
    # Extrai a primeira citação usando Expressões Regulares
    match = re.search(r'<span class="text" itemprop="text">(.*?)</span>', html)
    if match:
        print(match.group(1))
    else:
        print("Citação não encontrada.")
except Exception as e:
    print(f"Erro de extração: {e}", file=sys.stderr)