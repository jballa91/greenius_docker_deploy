-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "hashword" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Artist" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "genre" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Song" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "genre" TEXT NOT NULL,
    "artist_id" INTEGER NOT NULL,
    "lyrics" TEXT[],
    "img" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SongComment" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "song_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Annotation" (
    "id" SERIAL NOT NULL,
    "start_index" INTEGER NOT NULL,
    "end_index" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "song_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnnotationComment" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "annotation_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_song_liked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_song_disliked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_song_comment_liked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_song_comment_disliked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_song_annotation_liked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_song_annotation_disliked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_annotation_comment_liked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_annotation_comment_disliked_by" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User.username_unique" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "_song_liked_by_AB_unique" ON "_song_liked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_song_liked_by_B_index" ON "_song_liked_by"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_song_disliked_by_AB_unique" ON "_song_disliked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_song_disliked_by_B_index" ON "_song_disliked_by"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_song_comment_liked_by_AB_unique" ON "_song_comment_liked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_song_comment_liked_by_B_index" ON "_song_comment_liked_by"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_song_comment_disliked_by_AB_unique" ON "_song_comment_disliked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_song_comment_disliked_by_B_index" ON "_song_comment_disliked_by"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_song_annotation_liked_by_AB_unique" ON "_song_annotation_liked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_song_annotation_liked_by_B_index" ON "_song_annotation_liked_by"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_song_annotation_disliked_by_AB_unique" ON "_song_annotation_disliked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_song_annotation_disliked_by_B_index" ON "_song_annotation_disliked_by"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_annotation_comment_liked_by_AB_unique" ON "_annotation_comment_liked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_annotation_comment_liked_by_B_index" ON "_annotation_comment_liked_by"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_annotation_comment_disliked_by_AB_unique" ON "_annotation_comment_disliked_by"("A", "B");

-- CreateIndex
CREATE INDEX "_annotation_comment_disliked_by_B_index" ON "_annotation_comment_disliked_by"("B");

-- AddForeignKey
ALTER TABLE "Song" ADD FOREIGN KEY ("artist_id") REFERENCES "Artist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Song" ADD FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SongComment" ADD FOREIGN KEY ("song_id") REFERENCES "Song"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SongComment" ADD FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Annotation" ADD FOREIGN KEY ("song_id") REFERENCES "Song"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Annotation" ADD FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnnotationComment" ADD FOREIGN KEY ("annotation_id") REFERENCES "Annotation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnnotationComment" ADD FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_liked_by" ADD FOREIGN KEY ("A") REFERENCES "Song"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_liked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_disliked_by" ADD FOREIGN KEY ("A") REFERENCES "Song"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_disliked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_comment_liked_by" ADD FOREIGN KEY ("A") REFERENCES "SongComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_comment_liked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_comment_disliked_by" ADD FOREIGN KEY ("A") REFERENCES "SongComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_comment_disliked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_annotation_liked_by" ADD FOREIGN KEY ("A") REFERENCES "Annotation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_annotation_liked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_annotation_disliked_by" ADD FOREIGN KEY ("A") REFERENCES "Annotation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_song_annotation_disliked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_annotation_comment_liked_by" ADD FOREIGN KEY ("A") REFERENCES "AnnotationComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_annotation_comment_liked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_annotation_comment_disliked_by" ADD FOREIGN KEY ("A") REFERENCES "AnnotationComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_annotation_comment_disliked_by" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
