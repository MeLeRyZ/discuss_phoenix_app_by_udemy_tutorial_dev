FIRST PHOENIX APP!
0. Button for registration.
1. Page with list of topics
2. Page of create a topic if Signed in.
3. Page for editing a topic if Signed In. & Button for deleting.
4. Page detailed with theme.
5. Logout Button.
6. Comment block.
_______________________________________________
html <->
json <->      PHOENIX      <-> psql, PostgreSQL
sock <->
_______________________________________________
~~~
For instalation:

- NodeJS > 5.0
Install 64.deb OR use nvm package manager
Now last version is 8.9.4
link: https://losst.ru/ustanovka-node-js-ubuntu-16-04
- PostgreSQL. Stable version from apt
~~~
__________________________________________________
No. Example:
~~~
Incoming request ->
  -> Ensure its an HTML request
    -> See if it has a session
      -> Do a security check
        -> Put on HTTP headers for a browser
          -> See what the request was trying to access
            -> Formulate and return a request
~~~
__________________________________________________________
mix phx.server
iex -S mix phx.server
//////
username: "postgres",
password: "postgres",
- in config/dev.exs
then:
- sudo -u postgres psql
- alter user postgres password 'postgres';
Then:
- mix ecto.create
//////
DIFFERENCES 1.3:
1. apt-get install -y inotify-tools
2.  Create "model" -> cmd: mix phx.gen.schema NameContext Context some:string ... etc
_______________________________
Installing authentication:
1. Install ueberauth
2. Install additionally package ueberauth_provider
_______________________________
IF appears Error browser console looks like "cannot import phoenix",
THEN -> sudo nano /proc/sys/fs/inotify/max_user_watches
change number. I've change it to 100000.
