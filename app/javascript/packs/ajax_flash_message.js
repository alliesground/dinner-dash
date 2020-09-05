document.addEventListener('ajax:complete', function(event) {
  const xhr = event.detail[0];
  const msg = xhr.getResponseHeader("Flash-Message");

  if(msg) alert(msg);
})
