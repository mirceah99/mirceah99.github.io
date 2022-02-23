try{
    if('OTPCredential' in window){
const p = document.getElementById("your-code");
navigator.credentials.get({
    otp: {transport:['sms']},
    signal: (new AbortController()).signal
}).then( otp => {
    alert (document.getElementById("your-code"));
    alert('then');
    alert (document.getElementById("your-code"));
    alert('then2');
    alert(JSON.stringify(otp));
    p.value = otp.code;
}).catch(e =>{
    p.value = e;
})
    } else {alert("not possible");}
} catch(e) { alert(JSON.stringify(e));}