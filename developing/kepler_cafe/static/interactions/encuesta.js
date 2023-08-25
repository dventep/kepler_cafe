const stars = document.querySelectorAll('.star');

    stars.forEach(star => {
      star.addEventListener('click', function() {
        const rating = parseInt(this.getAttribute('data-rating'));
        const product = this.parentNode.getAttribute('data-product');
        setRating(product, rating);
      });
    });

    function setRating(product, rating) {
      const ratingContainer = document.querySelector(`[data-product="${product}"]`);
      const productStars = ratingContainer.querySelectorAll('.star');

      productStars.forEach(star => {
        const starRating = parseInt(star.getAttribute('data-rating'));
        if (starRating <= rating) {
          star.classList.add('active');
        } else {
          star.classList.remove('active');
        }
      });
    }