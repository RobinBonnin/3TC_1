//Pattern
function call1 (callback) {
  function _call1(i) {
  //Ancienne fonction
    i++;
    console.log("i -->" + i);
    if (i < 20) {
    //Pattern
      setTimeout(_call1, 0, i);
    } else {
		callback(); 
   }
}
  _call1(0);
  return 'ok';
 }
 

call1( function () {
	console.log('fini');
})
