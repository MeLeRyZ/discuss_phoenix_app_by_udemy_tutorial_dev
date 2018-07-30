
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicId) => {
    let channel = socket.channel(`comments:${topicId}`, {})
    channel.join()
        .receive("ok", resp => {
            //console.log("Joined successfully", resp)
            renderComments(resp.comments);
        })
        .receive("error", resp => {
            console.log("Unable to join", resp)
        })

        channel.on(`comments:${topicId}:new`, renderComment);

        document.querySelector('button').addEventListener('click', () => {
            const content = document.querySelector('textarea').value;

            channel.push('comment:add', {content: content});
        });
}

function renderComments(comments) { // for initial things
    const renderedComments = comments.map(comment => {
        return commentTemplate(comment);
    });
    document.querySelector('.collection').innerHTML = renderedComments.join('');
}

function renderComment(event) { // for adding to exist lists
    const renderedComment = commentTemplate(event.comment);
    document.querySelector('.collection').innerHTML += renderedComment;
}

function commentTemplate(comment) {
    return `
        <li class="collection-item">
            ${comment.content}
        <\li>
    `;
}

window.createSocket = createSocket;


// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.
