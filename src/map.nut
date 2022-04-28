for(local i = 0; i < 5; i++){
    objects.push(actor[newActor(solid, i * 16, 64)])
}
for(local i = 0; i < 10; i++){
    objects.push(actor[newActor(solid, 160, 16 * i)])
}
objects.push(actor[newActor(solid, 16, 16)])
objects.push(actor[newActor(solid, 32, 16)])
