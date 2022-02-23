const p = document.getElementById("your-code");
navigator.credentials.get({
    otp: {transport:['sms']},
    signal: (new AbortController()).signal
}).then( otp => {
    alert('then');
    p.value = otp.code;
}).catch(e =>{
    p.value = e;
})