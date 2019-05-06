function showBookSelectionView() {
    $("#books").width("100%");
    $("#chapters").width("0");
    $("#verses").width("0");
}

function showChapterSelectionView() {
    $("#books").width("50%");
    $("#chapters").width("50%").css("left", "50%");
    $("#verses").width("0%");
    $("#chapters .closebtn").show();
}

function showVersesView() {
    $("#books").width("15%");
    $("#chapters").width("15%").css("left", "15%");
    $("#verses").width("70%").css("left", "30%");
    $("#chapters .closebtn").hide();
}

