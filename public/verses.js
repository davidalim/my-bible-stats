function getChapterFromEsv(book, chapter) {
    // ESV api
    const API_KEY = '64485316353cc3e5e15f74ae7ee5ae734c0a0847'
    const API_URL = 'https://api.esv.org/v3/passage/html/'

    var passage = book + chapter;

    $.ajax({
        url: API_URL,
        type:"GET",
        data: { 
            'q': passage
        },
        headers: {
            'Authorization': 'Token ' + API_KEY
        },
        success: function(result){
            displayChapter(result)
        },
        error: function(error){
            console.log("Error ${error")
        }
    })
}

function displayChapter(html) {
    $("#bible-content").html(html['passages']);
}