document.addEventListener('DOMContentLoaded', function() {
    var eventTypeSelect = document.getElementById('order_event_type_id');
    var eventDateField = document.getElementById('order_event_date');

    if (eventTypeSelect && eventDateField) {
        eventTypeSelect.addEventListener('change', function() {
            var selectedEventTypeId = eventTypeSelect.value;
            updateCalendarForEventType(selectedEventTypeId);
        });

        eventDateField.addEventListener('input', function() {
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            var selectedDate = new Date(eventDateField.value);

            if (selectedDate < today) {
                alert('A data selecionada não pode ser no passado.');
                eventDateField.value = '';
                return;
            }
        });
    }

    function updateCalendarForEventType(eventTypeId) {
        if (!eventTypeId) return;

        fetch(`/event_types/${eventTypeId}/days`)
            .then(response => response.json())
            .then(data => {
                var validDays = data.days || [];
                configureDateField(validDays);
            })
            .catch(error => console.error('Erro ao buscar os dias do evento:', error));
    }

    function configureDateField(validDays) {
        eventDateField.addEventListener('input', function() {
            var selectedDate = new Date(eventDateField.value);
            var selectedDayIndex = selectedDate.getDay();

            if (!validDays.includes(selectedDayIndex)) {
                alert('O dia selecionado não é permitido para o tipo de evento escolhido.');
                eventDateField.value = '';
            }
        });
    }
});
