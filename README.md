# Графовая база данных Dgraph

Графовая база данных Dgraph для хранения связей между узлами, пользователями, транзакциями и ролями. 
И визуализиция графа через веб-интерфейс Ratel.

## ВСТАВКА ДАННЫХ

```bash
curl -X POST http://localhost:8080/mutate?commitNow=true \
  -H "Content-Type: application/json" \
  -d $'
{
  "set": [
    {
      "uid": "_:alice",
      "name": "Alice",
      "balance": 1000,
      "role": "manager",
      "type": "person"
    },
    {
      "uid": "_:bob",
      "name": "Bob",
      "balance": 500,
      "role": "employee",
      "type": "person"
    },
    {
      "uid": "_:charlie",
      "name": "Charlie",
      "balance": 2000,
      "role": "partner",
      "type": "person"
    },
    {
      "uid": "_:company_a",
      "name": "Company A",
      "type": "company"
    },
    {
      "uid": "_:project_x",
      "name": "Project X",
      "status": "active",
      "type": "project"
    },
    {
      "uid": "_:wallet_alice",
      "name": "Alice Wallet",
      "balance": 1000,
      "type": "wallet"
    },
    {
      "uid": "_:wallet_bob",
      "name": "Bob Wallet",
      "balance": 500,
      "type": "wallet"
    },
    {
      "uid": "_:wallet_charlie",
      "name": "Charlie Wallet",
      "balance": 2000,
      "type": "wallet"
    },
    {
      "uid": "_:wallet_company",
      "name": "Company Wallet",
      "balance": 10000,
      "type": "wallet"
    },
    {
      "uid": "_:wallet_project",
      "name": "Project Wallet",
      "balance": 5000,
      "type": "wallet"
    },
    {
      "uid": "_:transfer_1",
      "from": { "uid": "_:wallet_alice" },
      "to": { "uid": "_:wallet_bob" },
      "amount": 100,
      "date": "2025-12-23",
      "type": "transfer"
    }
  ]
}'
```

## Добавление связи между узлами

```bash
curl -X POST http://localhost:8080/mutate?commitNow=true \
  -H "Content-Type: application/json" \
  -d $'
{
  "set": [
    {
      "uid": "0x2",  // Alice
      "works_for": [
        { "uid": "0x9" }  // Company A
      ],
      "owns": [
        { "uid": "0x5" }  // Alice Wallet
      ]
    },
    {
      "uid": "0x8",  // Bob
      "works_for": [
        { "uid": "0x9" }  // Company A
      ],
      "owns": [
        { "uid": "0xa" }  // Bob Wallet
      ]
    },
    {
      "uid": "0x3",  // Charlie
      "owns": [
        { "uid": "0xb" }  // Charlie Wallet
      ]
    },
    {
      "uid": "0x4",  // Project X
      "has_wallet": [
        { "uid": "0xc" }  // Project Wallet
      ]
    },
    {
      "uid": "0x9",  // Company A
      "has_wallet": [
        { "uid": "0x6" }  // Company Wallet
      ]
    },
    {
      "uid": "0x7",  // transfer_1
      "from": { "uid": "0x5" },  // Alice Wallet
      "to": { "uid": "0xa" },    // Bob Wallet
      "amount": 100,
      "date": "2025-12-23"
    }
  ]
}
'
```

## Запрос в ratel, чтобы увидеть узлы и связи
```code
{
  all(func: has(type)) {
    uid
    name
    balance
    role
    status
    type
    works_for {
      uid
      name
    }
    owns {
      uid
      name
    }
    has_wallet {
      uid
      name
    }
    from {
      uid
      name
    }
    to {
      uid
      name
    }
  }
}
```