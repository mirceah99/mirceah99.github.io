try{
const p = document.getElementById("your-code");
navigator.credentials.get({
    otp: {transport:['sms']},
    signal: (new AbortController()).signal
}).then( otp => {
    alert('then');
    alert (p);
    alert(JSON.stringify(otp));
    p.value = otp.code;
}).catch(e =>{
    p.value = e;
})} catch(e) { alert(JSON.stringify(e));}