<!DOCTYPE>
<html>
<head>
    <title>My Bible Stats</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script type="text/javascript" src="sidenav.js"></script>
    <script type="text/javascript" src="verses.js"></script>
    <script type="text/javascript" src="bookdata.js"></script>
    <script type="application/json" class="js-hypothesis-config">
    {
        "theme": "clean"
    }
    </script>
    <script src="https://hypothes.is/embed.js" async></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="esv.css">
    <link rel="stylesheet" type="text/css" href="sidenav.css">
</head>
<body>
      <?php
        $servername = "127.0.0.1:3306";
        $username = "root";
        $password = "mysql";
        $dbname = "bible";

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);
        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        $conn->close();
      ?>
<div id="books" class="sidenav container">

</div>
<div id="chapters" class="sidenav2 container">
    <a href="javascript:void(0)" class="closebtn" onclick="closeChaptersView()">&times;</a>
</div>
<div id="verses" class="sidenav3 container">
    <a href="javascript:void(0)" class="closebtn" onclick="closeVersesView()">&times;</a>
    <div id="bible-content">
        Verses!
    </div>
</div>
<script type="text/javascript">

  var selectedBook = "";

  for (var bookname in bookdata) {
    console.log("Book " + bookname + " has " + bookdata[bookname] + " chapters");
    $( "#books" ).append( "<a class='bookname' href='#' onclick='openChaptersView()'>" + bookname + "</a>");
  }

  function displayChapters(bookname) {
    $("a").remove('.chapter');
    for (var i = 1; i <= bookdata[bookname]; i++) { 
      $("#chapters").append( "<a class='chapter' href='#' onclick='openVersesView()'>" + i + "</a>");
    }
  }

  $('body').on('click', '.bookname', function(e) {
    var bookname = $(e.target).text();
    selectedBook = bookname;
    displayChapters(bookname);
  });

  $('body').on('click', '.chapter', function(e) {
    var chapter = $(e.target).text();
    getChapterFromEsv(selectedBook, chapter);
  });

</script>
</body>
</html>
