package com.rank.interfaces;


public interface DrawableClickListener {

    public static enum DrawablePosition {TOP, BOTTOM, LEFT, RIGHT}

    public void onClick(DrawablePosition target);
}
