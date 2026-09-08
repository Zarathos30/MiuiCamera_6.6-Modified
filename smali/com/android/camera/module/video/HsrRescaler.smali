.class public final Lcom/android/camera/module/video/HsrRescaler;
.super Ljava/lang/Object;
.source "HsrRescaler.java"


# static fields
.field private static final BUF_SIZE:I = 0x400000

.field private static final TAG:Ljava/lang/String; = "HsrRescaler"

.field private static final TARGET_FPS:I = 0x1e


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static copyTrack(Landroid/media/MediaExtractor;Landroid/media/MediaMuxer;II)V
    .registers 18

    move/from16 v0, p3

    const/high16 v1, 0x400000

    .line 146
    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 147
    new-instance v2, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v2}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    const-wide/16 v3, -0x1

    :goto_f
    const/4 v5, 0x0

    .line 150
    invoke-virtual {p0, v1, v5}, Landroid/media/MediaExtractor;->readSampleData(Ljava/nio/ByteBuffer;I)I

    move-result v5

    if-gez v5, :cond_17

    return-void

    .line 154
    :cond_17
    invoke-virtual {p0}, Landroid/media/MediaExtractor;->getSampleTime()J

    move-result-wide v6

    .line 155
    invoke-virtual {p0}, Landroid/media/MediaExtractor;->getSampleFlags()I

    move-result v8

    int-to-long v8, v8

    const-wide/16 v10, 0x0

    cmp-long v10, v3, v10

    if-gez v10, :cond_28

    move-wide v10, v6

    goto :goto_29

    :cond_28
    move-wide v10, v3

    :goto_29
    const/4 v3, 0x1

    if-ne v0, v3, :cond_2d

    goto :goto_31

    :cond_2d
    sub-long/2addr v6, v10

    int-to-long v3, v0

    mul-long/2addr v6, v3

    add-long/2addr v6, v10

    :goto_31
    const/4 v3, 0x0

    long-to-int v4, v8

    move-wide v12, v6

    move v7, v4

    move v4, v5

    move-wide v5, v12

    .line 160
    invoke-virtual/range {v2 .. v7}, Landroid/media/MediaCodec$BufferInfo;->set(IIJI)V

    move-object v3, v2

    move/from16 v2, p2

    .line 161
    invoke-virtual {p1, v2, v1, v3}, Landroid/media/MediaMuxer;->writeSampleData(ILjava/nio/ByteBuffer;Landroid/media/MediaCodec$BufferInfo;)V

    .line 162
    invoke-virtual {p0}, Landroid/media/MediaExtractor;->advance()Z

    move-object v2, v3

    move-wide v3, v10

    goto :goto_f
.end method

.method private static rescale(Ljava/io/File;I)V
    .registers 18

    move/from16 v0, p1

    .line 56
    const-string v1, "HsrRescaler"

    new-instance v2, Landroid/media/MediaExtractor;

    invoke-direct {v2}, Landroid/media/MediaExtractor;-><init>()V

    .line 58
    new-instance v3, Ljava/io/File;

    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v4

    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ".rescale.tmp"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const/4 v4, 0x0

    .line 60
    :try_start_2a
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/media/MediaExtractor;->setDataSource(Ljava/lang/String;)V

    .line 66
    invoke-virtual {v2}, Landroid/media/MediaExtractor;->getTrackCount()I

    move-result v5

    const/4 v6, 0x0

    const/4 v7, -0x1

    move-object v10, v4

    move-object v12, v10

    move v8, v6

    move v9, v7

    move v11, v9

    :goto_3c
    if-ge v8, v5, :cond_67

    .line 68
    invoke-virtual {v2, v8}, Landroid/media/MediaExtractor;->getTrackFormat(I)Landroid/media/MediaFormat;

    move-result-object v13

    .line 69
    const-string v14, "mime"

    invoke-virtual {v13, v14}, Landroid/media/MediaFormat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    if-nez v14, :cond_4b

    goto :goto_64

    .line 73
    :cond_4b
    const-string v15, "video/"

    invoke-virtual {v14, v15}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v15

    if-eqz v15, :cond_58

    if-gez v9, :cond_58

    move v9, v8

    move-object v10, v13

    goto :goto_64

    .line 76
    :cond_58
    const-string v15, "audio/"

    invoke-virtual {v14, v15}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v14
    :try_end_5e
    .catchall {:try_start_2a .. :try_end_5e} :catchall_103

    if-eqz v14, :cond_64

    if-gez v11, :cond_64

    move v11, v8

    move-object v12, v13

    :cond_64
    :goto_64
    add-int/lit8 v8, v8, 0x1

    goto :goto_3c

    :cond_67
    if-ltz v9, :cond_fa

    if-nez v10, :cond_6d

    goto/16 :goto_fa

    .line 88
    :cond_6d
    :try_start_6d
    new-instance v5, Landroid/media/MediaMetadataRetriever;

    invoke-direct {v5}, Landroid/media/MediaMetadataRetriever;-><init>()V

    .line 89
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Landroid/media/MediaMetadataRetriever;->setDataSource(Ljava/lang/String;)V

    const/16 v8, 0x18

    .line 90
    invoke-virtual {v5, v8}, Landroid/media/MediaMetadataRetriever;->extractMetadata(I)Ljava/lang/String;

    move-result-object v8

    .line 92
    invoke-virtual {v5}, Landroid/media/MediaMetadataRetriever;->release()V

    if-eqz v8, :cond_89

    .line 94
    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5
    :try_end_88
    .catchall {:try_start_6d .. :try_end_88} :catchall_89

    goto :goto_8a

    :catchall_89
    :cond_89
    move v5, v6

    .line 100
    :goto_8a
    :try_start_8a
    new-instance v8, Landroid/media/MediaMuxer;

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v8, v13, v6}, Landroid/media/MediaMuxer;-><init>(Ljava/lang/String;I)V
    :try_end_93
    .catchall {:try_start_8a .. :try_end_93} :catchall_103

    if-eqz v5, :cond_98

    .line 103
    :try_start_95
    invoke-virtual {v8, v5}, Landroid/media/MediaMuxer;->setOrientationHint(I)V

    .line 105
    :cond_98
    invoke-virtual {v8, v10}, Landroid/media/MediaMuxer;->addTrack(Landroid/media/MediaFormat;)I

    move-result v4

    if-ltz v11, :cond_a4

    if-eqz v12, :cond_a4

    .line 108
    invoke-virtual {v8, v12}, Landroid/media/MediaMuxer;->addTrack(Landroid/media/MediaFormat;)I

    move-result v7

    .line 110
    :cond_a4
    invoke-virtual {v8}, Landroid/media/MediaMuxer;->start()V

    if-ltz v11, :cond_b3

    .line 113
    invoke-virtual {v2, v11}, Landroid/media/MediaExtractor;->selectTrack(I)V

    const/4 v5, 0x1

    .line 114
    invoke-static {v2, v8, v7, v5}, Lcom/android/camera/module/video/HsrRescaler;->copyTrack(Landroid/media/MediaExtractor;Landroid/media/MediaMuxer;II)V

    .line 115
    invoke-virtual {v2, v11}, Landroid/media/MediaExtractor;->unselectTrack(I)V

    .line 118
    :cond_b3
    invoke-virtual {v2, v9}, Landroid/media/MediaExtractor;->selectTrack(I)V

    .line 119
    invoke-static {v2, v8, v4, v0}, Lcom/android/camera/module/video/HsrRescaler;->copyTrack(Landroid/media/MediaExtractor;Landroid/media/MediaMuxer;II)V

    .line 121
    invoke-virtual {v8}, Landroid/media/MediaMuxer;->stop()V

    .line 122
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->delete()Z

    move-object/from16 v4, p0

    .line 123
    invoke-virtual {v3, v4}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v5

    if-nez v5, :cond_cc

    .line 124
    const-string v5, "rename failed"

    invoke-static {v1, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 126
    :cond_cc
    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "rescaled "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " x"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_f0
    .catchall {:try_start_95 .. :try_end_f0} :catchall_f7

    .line 132
    :try_start_f0
    invoke-virtual {v2}, Landroid/media/MediaExtractor;->release()V
    :try_end_f3
    .catchall {:try_start_f0 .. :try_end_f3} :catchall_f3

    .line 137
    :catchall_f3
    :try_start_f3
    invoke-virtual {v8}, Landroid/media/MediaMuxer;->release()V
    :try_end_f6
    .catchall {:try_start_f3 .. :try_end_f6} :catchall_114

    goto :goto_114

    :catchall_f7
    move-exception v0

    move-object v4, v8

    goto :goto_104

    .line 82
    :cond_fa
    :goto_fa
    :try_start_fa
    const-string v0, "no video track, skip"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_ff
    .catchall {:try_start_fa .. :try_end_ff} :catchall_103

    .line 132
    :try_start_ff
    invoke-virtual {v2}, Landroid/media/MediaExtractor;->release()V
    :try_end_102
    .catchall {:try_start_ff .. :try_end_102} :catchall_102

    :catchall_102
    return-void

    :catchall_103
    move-exception v0

    .line 128
    :goto_104
    :try_start_104
    const-string v5, "rescale error"

    invoke-static {v1, v5, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 129
    invoke-virtual {v3}, Ljava/io/File;->delete()Z
    :try_end_10c
    .catchall {:try_start_104 .. :try_end_10c} :catchall_115

    .line 132
    :try_start_10c
    invoke-virtual {v2}, Landroid/media/MediaExtractor;->release()V
    :try_end_10f
    .catchall {:try_start_10c .. :try_end_10f} :catchall_10f

    :catchall_10f
    if-eqz v4, :cond_114

    .line 137
    :try_start_111
    invoke-virtual {v4}, Landroid/media/MediaMuxer;->release()V
    :try_end_114
    .catchall {:try_start_111 .. :try_end_114} :catchall_114

    :catchall_114
    :cond_114
    :goto_114
    return-void

    :catchall_115
    move-exception v0

    .line 132
    :try_start_116
    invoke-virtual {v2}, Landroid/media/MediaExtractor;->release()V
    :try_end_119
    .catchall {:try_start_116 .. :try_end_119} :catchall_119

    :catchall_119
    if-eqz v4, :cond_11e

    .line 137
    :try_start_11b
    invoke-virtual {v4}, Landroid/media/MediaMuxer;->release()V
    :try_end_11e
    .catchall {:try_start_11b .. :try_end_11e} :catchall_11e

    .line 141
    :catchall_11e
    :cond_11e
    throw v0
.end method

.method public static rescaleIfSlowMotion(Ljava/io/File;)V
    .registers 5

    if-eqz p0, :cond_46

    .line 31
    :try_start_2
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_9

    goto :goto_46

    .line 34
    :cond_9
    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    .line 35
    const-string v1, "_HSR_"

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    if-gez v1, :cond_16

    goto :goto_46

    :cond_16
    add-int/lit8 v1, v1, 0x5

    move v2, v1

    .line 41
    :goto_19
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_2c

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/Character;->isDigit(C)Z

    move-result v3

    if-eqz v3, :cond_2c

    add-int/lit8 v2, v2, 0x1

    goto :goto_19

    .line 44
    :cond_2c
    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 45
    div-int/lit8 v0, v0, 0x1e

    const/4 v1, 0x1

    if-gt v0, v1, :cond_3a

    goto :goto_46

    .line 49
    :cond_3a
    invoke-static {p0, v0}, Lcom/android/camera/module/video/HsrRescaler;->rescale(Ljava/io/File;I)V
    :try_end_3d
    .catchall {:try_start_2 .. :try_end_3d} :catchall_3e

    return-void

    :catchall_3e
    move-exception p0

    .line 51
    const-string v0, "HsrRescaler"

    const-string v1, "rescaleIfSlowMotion failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_46
    :goto_46
    return-void
.end method
