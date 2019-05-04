function openChaptersView() {
    document.getElementById("books").style.width = "50%";
    document.getElementById("chapters").style.width = "50%";
    document.getElementById("chapters").style.left = "50%";
}
function closeChaptersView() {
    document.getElementById("chapters").style.width = "0";
    openBooksView();
}
function openBooksView() {
    document.getElementById("books").style.width = "100%";
}
function closeBooksView() {
    document.getElementById("books").style.width = "0";

}
function openChaptersView() {
    document.getElementById("books").style.width = "50%";
    document.getElementById("chapters").style.width = "50%";
    document.getElementById("chapters").style.left = "50%";
    closeVersesView();
}
function closeChaptersView() {
    document.getElementById("chapters").style.width = "0";
    openBooksView();
}
function openVersesView() {
    // TODO: query verses from API
    document.getElementById("verses").style.width = "70%";
    minimizeBookChapterViews();
}
function closeVersesView() {
    // TODO: do whatever needs to be done to close verse view
    document.getElementById("verses").style.width = "0%";
    openChaptersView();
}
function minimizeBookChapterViews() {
    document.getElementById("books").style.width = "15%";
    document.getElementById("chapters").style.width = "15%";
    document.getElementById("chapters").style.left = "15%";
    
}