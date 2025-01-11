document.addEventListener('turbo:load', () => {
    const form = document.getElementById('shortener-form');
    const resultDiv = document.getElementById('result');

    if (form) {
        form.addEventListener('submit', async (event) => {
            event.preventDefault();
            const originalUrl = document.getElementById('original-url').value;
            const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

            try {
                const response = await fetch('/links', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': csrfToken
                    },
                    body: JSON.stringify({ link: { original_url: originalUrl } })
                });

                if (response.redirected) {
                    // Handle server-side redirect
                    window.location.href = response.url;
                } else {
                    const data = await response.json();
                    if (response.ok) {
                        resultDiv.innerHTML = `
                            <p>Shortened URL: <a href="${data.short_url}" target="_blank">${data.short_url}</a></p>
                        `;
                    } else {
                        resultDiv.textContent = data.errors ? data.errors.join(', ') : 'An error occurred.';
                    }
                }
            } catch (error) {
                resultDiv.textContent = 'An error occurred. Please try again.';
            }
        });
    }
});
