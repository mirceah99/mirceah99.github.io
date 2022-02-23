const p = document.getElementById("your-code");
navigator.credentials.get({
    otp: {transport:['sms']}
}).then( otp => {
    p.value = otp.code;

}).catch(e =>{
    p.value = e;
})