async function  loadHtml(divId, htmlFile){
    let xHttp;
    const divElement = document.getElementById(divId);
    // console.log('window.location', window.location);
    // let oldUrl = window.location.toString();
    // console.log('oldUrl', oldUrl);
    // let url = oldUrl.replace('index.html', htmlFile);
    // console.log('url', url);
    if ( htmlFile ){
        xHttp = await new XMLHttpRequest();
        xHttp.onreadystatechange = function () {
            console.log('this.readyState', this.readyState);
            console.log('this.status', this.status);
            if(this.readyState == 4){
                if(this.status === 200) {divElement.innerHTML = this.responseText;}
                else { divElement.innerHTML = '<h1>There was an error :(</h1>'}
            }
        }
    }
    xHttp.open('GET', htmlFile, true);
    xHttp.send();
    return;
}
