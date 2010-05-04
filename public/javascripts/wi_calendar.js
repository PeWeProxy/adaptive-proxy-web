function displayNextMonth(current) {
  document.getElementById('_wi_month' + current).style.display = 'none';
  next = current + 1;
  document.getElementById('_wi_month' + next).style.display = 'inline';
}

function displayPrevMonth(current) {
  document.getElementById('_wi_month' + current).style.display = 'none';
  prev = current - 1;
  document.getElementById('_wi_month' + prev).style.display = 'inline';
}