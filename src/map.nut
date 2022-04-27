::gvPlayer <- newActor(Tux, 300, 300)
::gvPlayer2 <- newActor(Tux, 100, 100)

for(local i = 0; i < 5; i++){
    objects.push(actor[newActor(Solid, i * 16, 64)])
}
for(local i = 0; i < 10; i++){
    objects.push(actor[newActor(Solid, 160, 16 * i)])
}
objects.push(actor[newActor(Solid, 16, 16)])
objects.push(actor[newActor(Solid, 32, 16)])