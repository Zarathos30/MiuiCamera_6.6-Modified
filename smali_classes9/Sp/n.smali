.class public final LSp/n;
.super Ljava/lang/Object;
.source "NalAnnexBFix.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Ljava/nio/ByteBuffer;Landroid/media/MediaCodec$BufferInfo;)Ljava/nio/ByteBuffer;
    .locals 10

    :try_start_0
    iget v0, p1, Landroid/media/MediaCodec$BufferInfo;->offset:I

    iget v1, p1, Landroid/media/MediaCodec$BufferInfo;->size:I

    const/16 v2, 0x8

    if-lt v1, v2, :goto_orig

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v3

    add-int v4, v0, v1

    move v5, v0

    const/4 v6, 0x0

    :loop
    sub-int v7, v4, v5

    const/4 v8, 0x4

    if-lt v7, v8, :tail

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->getInt(I)I

    move-result v7

    const/4 v8, 0x2

    if-lt v7, v8, :goto_orig

    add-int/2addr v7, v5

    const/4 v8, 0x4

    add-int/2addr v7, v8

    if-le v7, v4, :len_ok

    goto :goto_orig

    :len_ok
    if-nez v6, :have_out

    shl-int/lit8 v8, v1, 0x1

    add-int/lit8 v8, v8, 0x10

    invoke-static {v8}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    :have_out
    const v8, 0x1000000

    invoke-virtual {v6, v8}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v5, 0x4

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->duplicate()Ljava/nio/ByteBuffer;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    invoke-virtual {v9, v7}, Ljava/nio/Buffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {v6, v9}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    move v5, v7

    goto :loop

    :tail
    if-eq v5, v4, :converted

    goto :goto_orig

    :converted
    invoke-virtual {v6}, Ljava/nio/Buffer;->position()I

    move-result v7

    const/4 v8, 0x0

    invoke-virtual {v6, v8}, Ljava/nio/Buffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {v6, v8}, Ljava/nio/Buffer;->position(I)Ljava/nio/Buffer;

    iput v8, p1, Landroid/media/MediaCodec$BufferInfo;->offset:I

    iput v7, p1, Landroid/media/MediaCodec$BufferInfo;->size:I

    const-string v0, "NALFIX"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "converted length-prefixed -> AnnexB, size="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v8, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v8}, Lcom/android/camera/log/Log;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v6

    :goto_orig
    return-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    move-exception v0

    const-string v1, "NALFIX"

    invoke-static {v1, v0}, Lcom/android/camera/log/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-object p0
.end method
