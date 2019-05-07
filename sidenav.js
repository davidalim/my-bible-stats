const view = {
    BOOK: 'book',
    CHAPTER: 'chapter',
    VERSES: 'verses'
}

var currView = view.BOOK;
var currViewMode = isOneViewMode();

function showBookSelectionView() {
    $("#books").width("100%");
    $("#chapters").width("0");
    $("#verses").width("0");
    currView = view.BOOK;
}

function showChapterSelectionView() {
    if (isOneViewMode()) {
        $("#books").width("0%");
        $("#chapters").width("100%").css("left", "0%");
    } else {
        $("#books").width("50%");
        $("#chapters").width("50%").css("left", "50%");
    }
    $("#verses").width("0%");
    $("#chapters .closebtn").show();
    currView = view.CHAPTER;
}

function showVersesView() {
    if (isOneViewMode()) {
        $("#books").width("0%");
        $("#chapters").width("0%");
        $("#verses").width("100%");
    } else {
        $("#books").width("15%");
        $("#chapters").width("15%").css("left", "15%");
        $("#verses").width("70%").css("left", "30%");
    }
    $("#chapters .closebtn").hide();
    currView = view.VERSES;
}

function isOneViewMode() {
    return isMobile() || isSmallScreen();
}

function isMobile() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
}

function isSmallScreen() { 
    return window.matchMedia('(max-width: 1100px)').matches;
}

function refreshView() {
    switch(currView){
    case view.BOOK:
        console.log("Showing book view");
        showBookSelectionView();
        break;
    case view.CHAPTER:
        console.log("Showing chapter view");
        showChapterSelectionView();
        break;
    case view.VERSES:
        console.log("Showing verses view");
        showVersesView();
    }
}

function refreshViewIfNeeded() {
    if(currViewMode != isOneViewMode()){
        refreshView();
    }
    currViewMode = isOneViewMode();
}

$( document ).ready(function() {
    /* Attach the function to the resize event listener */
    window.addEventListener('resize', refreshViewIfNeeded, false);  
});