document.getElementById('pk').addEventListener('change', function() {
	var selectedCategory = this.value;
	var productCards = document.querySelectorAll('.product-card');
	
	productCards.forEach(function(card) {
		if (selectedCategory === '' || card.querySelector('.product-category').textContent.includes(selectedCategory)) {
			card.classList.remove('d-none');
		} else {
			card.classList.add('d-none');
		}
	});
});