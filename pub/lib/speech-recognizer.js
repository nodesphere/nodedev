(function($) {

    $(document).ready(function() {

        try {
            var recognition = new webkitSpeechRecognition();
        } catch(e) {
            var recognition = Object;
        }
        recognition.continuous = true;
        recognition.interimResults = true;

        var interimResult = '';
        var textArea = $('#speech-page-content');
        var textAreaID = 'speech-page-content';
		
        $('body').click(function()
		{
			if (1)
			{
				console.log("starting recognition");
				startRecognition();
			}
        });

        $('.speech-mic-works').click(function(){
            recognition.stop();
        });

        var startRecognition = function() {
            console.log("Starting recognition...");
           // $('.speech-content-mic').removeClass('speech-mic').addClass('speech-mic-works');
           // textArea.focus();
            recognition.start();
        };

        recognition.onresult = function (event) {

            console.log("r");
            var pos = textArea.getCursorPosition() - interimResult.length;
            textArea.val(textArea.val().replace(interimResult, ''));
            interimResult = '';
            textArea.setCursorPosition(pos);
            for (var i = event.resultIndex; i < event.results.length; ++i) {
                if (event.results[i].isFinal) {
                    insertAtCaret(textAreaID, event.results[i][0].transcript);


					console.log(event.results[i][0].transcript);
					
					var msg = event.results[i][0].transcript;
					
					if (msg.charAt(0) == " ")
						msg = msg.substr(1, msg.length);
					
					//sendMessageToVega(msg);
					
                } else {
                    isFinished = false;
                    insertAtCaret(textAreaID, event.results[i][0].transcript + '\u200B');
                    interimResult += event.results[i][0].transcript + '\u200B';
					
					console.log("mini result:", event.results[i][0].transcript);
					
				//	var msg = event.results[i][0].transcript;
				//	if (msg.charAt(0) == " ")
				//	{
				//		msg = msg.substr(1, msg.length);
				//		console.log("SENDING:", msg);
				//		sendMessageToVega(msg);
					//}
					
                }
            }
        };

        recognition.onend = function()
        {
		// recognition.start();
			//console.log("restarting");
        //    $('.speech-content-mic').removeClass('speech-mic-works').addClass('speech-mic');
        };
		
		startRecognition();
    });
})(jQuery);