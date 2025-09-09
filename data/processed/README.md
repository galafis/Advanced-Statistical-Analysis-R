# Processed Data Directory

Este diretório contém dados processados e limpos, prontos para análise.

## Estrutura

Os dados aqui foram:
- Limpos e validados
- Transformados conforme necessário
- Formatados para análise
- Documentados adequadamente

## Formatos Suportados

- CSV: Dados tabulares principais
- RData: Objetos R salvos
- Parquet: Dados grandes otimizados
- JSON: Dados estruturados

## Convenções de Nomenclatura

`processed_[dataset]_[data].[formato]`

Exemplo: `processed_sales_2025-09-09.csv`

## Metadados

Cada dataset processado deve incluir:
- Arquivo de metadados (.json)
- Documentação das transformações
- Dicionário de variáveis
