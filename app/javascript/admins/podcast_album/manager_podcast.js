let podcast_id = 0
let podcast_url = 'http://127.0.0.1:3000/admins/podcasts'

function updatePodcast(podcastId){
    console.log(podcast_url)
    console.log(podcastId)
    $.ajax({
        type: 'GET',
        url: podcast_url + '/' + podcastId
    })
        .done((data) => {
            let name = $(`#input_name_podcast_${podcastId}`).val();
            console.log(name)
            let obj = {
                name: name
            }
            console.log(obj)
            $.ajax({
                type: 'PATCH',
                url: `${podcast_url}/${podcastId}`,
                dataType: 'json',
                data: obj
            })
                .done((podcast) => {
                    alert("Update successfully")
                    $(`#input_name_podcast_${podcastId}`).val(podcast.name)
                })
                .fail((error) => {
                    console.log(error);
                })
        })
        .fail((error_data) => {
            console.log(error_data.errors);
        })
}

function deletePodcast(podcastId){
    $.ajax({
        type: 'GET',
        url: podcast_url + '/' + podcastId
    })
        .done((data) => {
            let id = data.id
            let confirmed = confirm("Are you sure to delete this podcast?")
            if(confirmed){
                $.ajax({
                    headers: {
                        'accept': 'application/json',
                        'content-type': 'application/json'
                    },
                    type: 'DELETE',
                    url: podcast_url + '/' + id,
                })
                    .done(() => {

                        $('#podcast-' + id).remove();

                    })
                    .fail((error) => {
                        console.log(error)
                    })
            }
        })
        .fail((error) => {
            console.log(error);
        })
}

function cancelEdit(podcastId){
    $.ajax({
        type: 'GET',
        url: podcast_url + '/' + podcastId
    })
        .done((data) => {
            $(`#input_name_podcast_${podcastId}`).val(data.name);
        })
        .fail((error) => {
            console.log(error);
        })
}