var myEncrypt = {
  pass: CryptoJS.enc.Utf8.parse("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"),
  iv: CryptoJS.enc.Hex.parse("0000000000000000"),

  encrypt: function(msg){
    var options = { mode: CryptoJS.mode.CBC, iv:this.iv };
    var json = CryptoJS.AES.encrypt(msg,this.pass, options);
    return json.ciphertext.toString(CryptoJS.enc.Base64);
  },

  decrypt: function(msg){
      var options = { mode: CryptoJS.mode.CBC, iv:this.iv };
      var json = CryptoJS.AES.decrypt(
        {ciphertext:CryptoJS.enc.Base64.parse(msg)}
        ,this.pass, options);
      return json.toString(CryptoJS.enc.Utf8);
  }

}
