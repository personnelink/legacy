//Creates the magnetic stripe reader, claims it for exclusive use, adds a data event listener, 
//and enables it to receive data.
var _reader = null;
var _claimedReader = null;

function startRead() {
    Windows.Devices.PointOfService.MagneticStripeReader.getDefaultAsync().then(function (reader) {
        if (reader !== null) {
            _reader = reader;
            
            reader.claimReaderAsync().done(function (claimedReader) {
                _claimedReader = claimedReader;
                claimedReader.isDecodeDataEnabled = true;
               
                claimedReader.addEventListener("bankcarddatareceived", onBankCardDataReceived);
                claimedReader.enableAsync().done(function () {
                   
                    document.getElementById("startReadButton").disabled = true;
                    document.getElementById("endReadButton").disabled = false;
                }, function error(e) {
                    // "Failed to enable the magnetic stripe reader."
                });
            }, function error(e) {
                //"Could not claim the magnetic stripe reader."
            });
        }
        else {
            //"Could not claim the magnetic stripe reader."
        }
           
    }, function error(e) {
        //"Magnetic stripe reader not found. Connect a magnetic stripe reader."
    });
}