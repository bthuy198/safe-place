
document.addEventListener('DOMContentLoaded', function() {
    // Lắng nghe sự kiện khi nút Join được nhấp vào
    
    let outbutton = document.getElementById('out_room_id')
    outbutton.addEventListener('click', function(){
        const roomId = this.getAttribute('data-room-id')
        outRoomAjax(roomId)
    })
})

function outRoomAjax(roomId) {
    console.log(roomId);
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    $.ajax(`/users/rooms/${roomId}/out_room`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
    })
    .then(data => {
      console.log('lala')
      if (data.status == 200) {
        alert('Join room successfully.');
        window.location.href = `/users/rooms`
      } else {
        alert('Failed to join room.');
      }
    })
}

