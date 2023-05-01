const MainBody = $("#MainBody")
const plate = $("#Plate")
const onbtn = $("#on-btn") 
const offbtn = $("#off-btn") 



const OpenUi = () => {
    MainBody.fadeIn()
}

window.addEventListener("message", (Event) => {
    if (Event.data.OpenUi) {
        OpenUi()
        plate.text(Event.data.plate)
    }
})


// on
onbtn.click(() => {
    $.post("https://cv-autopilot/on", JSON.stringify())
})

// off
offbtn.click(() => {
    $.post("https://cv-autopilot/off", JSON.stringify())
})

const CloseUi = () => {
    MainBody.fadeOut()
    $.post("https://cv-autopilot/CloseUi")
}

window.addEventListener("message", (Event) => {
    if (Event.data.CloseUi) {
        CloseUi()
    }
})



document.onkeydown = (Event) => {
    if (Event.keyCode == 27)
    CloseUi()
}