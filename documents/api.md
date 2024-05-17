# API Documentation

## Endpoints

### Buffets

### -> **List Buffets**

**GET** `/api/v1/buffets`

**Description:** Retorna uma lista de todos os buffets ou realiza uma busca por nome se o parâmetro `search` for fornecido.

**Parameters:**
- `search` (query, optional): Termo de busca para filtrar buffets pelo nome.

**Response:**
- **Status 200 OK:**
  ```json
  [
    {
      "id": 1,
      "name": "Buffet Example",
      "phone": "123456789",
      "contact_email": "example@example.com",
      "address": "123 Example St",
      "district": "Example District",
      "state": "Example State",
      "city": "Example City",
      "description": "A great buffet",
      "payment_methods": "Credit, Debit",
      "zip_code": "12345-678"
    },
    ...
  ]

### -> **Show Buffet**

**GET** `/api/v1/buffets/:id`

**Description:** Retorna os detalhes de um buffet específico.

**Parameters:**
- `id` (path, required): ID do buffet.

**Response:**
- **Status 200 OK:**
  ```json
  {
    "id": 1,
    "name": "Buffet Example",
    "phone": "123456789",
    "contact_email": "example@example.com",
    "address": "123 Example St",
    "district": "Example District",
    "state": "Example State",
    "city": "Example City",
    "description": "A great buffet",
    "payment_methods": "Credit, Debit",
    "zip_code": "12345-678"
  }

**Response:**
- **Status 404 Not Found:**
  ```json
  {
  "error": "Buffet not found"
  }

### -> **List Event Types for a Buffet**

**GET** `/api/v1/buffets/:buffet_id/event_types`

**Description:** Retorna uma lista de todos os tipos de eventos para um buffet específico.

**Parameters:**
- `buffet_id` (path, required): ID do buffet.

**Response:**
- **Status 200 OK:**
  ```json
  [
    {
      "id": 1,
      "name": "Wedding",
      "description": "A beautiful wedding event"
    },
    ...
  ]

**Response:**
- **Status 404 Not Found:**
  ```json
  {
  "error": "Buffet not found"
  }


#### -> **Check Event Type Availability**

**POST** `/api/v1/buffets/:buffet_id/event_types/:id/check_availability`

**Description:** Verifica a disponibilidade de um tipo de evento em uma data específica e retorna o preço estimado.

**Parameters:**
- `buffet_id` (path, required): ID do buffet.
- `id` (path, required): ID do tipo de evento.
- `event_date` (body, required): Data do evento no formato `YYYY-MM-DD`.
- `guest_count` (body, required): Número de convidados.

**Request Body:**
```json
{
  "event_date": "2024-06-01",
  "guest_count": 100
}
```

**Response:**
- **Status 200 OK:**
  ```json
  {
  "available": true,
  "estimated_price": 5000
  }
**Response:**
- **Status 422 Unprocessable Entity:**
  ```json
  {
  "available": false,
  "error": "No price set for this day"
  }
  ```
  ```json
  {
  "available": false,
  "error": "Event type not available on this date for the specified guest count"
  }
  ```
  ```json
  {
  "available": false,
  "error": "Event type not available on this day of the week"
  }
  

**Response:**
- **Status 404 Not Found:**
  ```json
  {
  "error": "Buffet not found"
  }
  ```
  ```json
  {
  "error": "Event type not found"
  }
  ```

  





  
