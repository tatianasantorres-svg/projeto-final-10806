#!/bin/bash
# pipeline.sh - Pipeline de Extração de Dados (ETL)
# Recolhe cambio EUR/USD via API e citação via scraping, e regista tudo num log

# Passo 1: Cabeçalho com data e hora atual (cria/substitui o ficheiro)
DATA=$(date "+%Y-%m-%d %H:%M:%S")
echo "=== Relatório gerado a: $DATA ===" > relatorio.log

# Passo 2: Consumir a API cambial (Frankfurter) de forma silenciosa
RESPOSTA_API=$(curl -s -L "https://api.frankfurter.app/latest?from=EUR&to=USD")

# Passo 3: Filtrar o JSON com jq para obter apenas o valor numerico do Dolar
CAMBIO=$(echo "$RESPOSTA_API" | jq '.rates.USD')

# Passo 4: Executar o script Python de scraping e guardar o resultado
CITACAO=$(python3 scraper.py)

# Passo 5: Escrever os resultados no relatorio.log (adicionar, nao substituir)
echo "Câmbio EUR para USD: $CAMBIO" >> relatorio.log
echo "Citação do dia: \"$CITACAO\"" >> relatorio.log
echo "-----------------------------------------------" >> relatorio.log

echo "Pipeline concluído! Verifica o ficheiro relatorio.log"
