window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const tax = 10
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue/tax).toLocaleString()
    const profitFee = document.getElementById("profit");
    profitFee.innerHTML = Math.floor(inputValue-Math.floor(inputValue/tax)).toLocaleString()
  })
});