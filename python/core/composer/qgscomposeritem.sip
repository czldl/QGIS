/** \ingroup MapComposer
 * A item that forms part of a map composition.
 */
class QgsComposerItem : QObject, QGraphicsRectItem
{
%TypeHeaderCode
#include <qgscomposeritem.h>
#include <qgscomposerlabel.h>
#include <qgscomposerlegend.h>
#include <qgscomposermap.h>
#include <qgspaperitem.h>
#include <qgscomposerpicture.h>
#include <qgscomposerscalebar.h>
#include <qgscomposershape.h>
#include <qgscomposertable.h>
#include <qgscomposerattributetable.h>
%End

%ConvertToSubClassCode
  // the conversions have to be static, because they're using multiple inheritance
  // (seen in PyQt4 .sip files for some QGraphicsItem classes)
  switch (sipCpp->type())
  {
  case QgsComposerItem::ComposerItem:
    sipClass = sipClass_QgsComposerItem;
    *sipCppRet = static_cast<QgsComposerItem*>(sipCpp);
    break;
#if 0
  case QgsComposerItem::ComposerArrow:
    sipClass = sipClass_QgsComposerArrow;
    *sipCppRet = static_cast<QgsComposerArrow*>(sipCpp);
    break;
  case QgsComposerItem::ComposerItemGroup:
    sipClass = sipClass_QgsComposerItemGroup;
    *sipCppRet = static_cast<QgsComposerItemGroup*>(sipCpp);
    break;
#endif
  case QgsComposerItem::ComposerLabel:
    sipClass = sipClass_QgsComposerLabel;
    *sipCppRet = static_cast<QgsComposerLabel*>(sipCpp);
    break;
  case QgsComposerItem::ComposerLegend:
    sipClass = sipClass_QgsComposerLegend;
    *sipCppRet = static_cast<QgsComposerLegend*>(sipCpp);
    break;
  case QgsComposerItem::ComposerMap:
    sipClass = sipClass_QgsComposerMap;
    *sipCppRet = static_cast<QgsComposerMap*>(sipCpp);
    break;
  case QgsComposerItem::ComposerPaper:
    sipClass = sipClass_QgsPaperItem;
    *sipCppRet = static_cast<QgsPaperItem*>(sipCpp);
    break;
  case QgsComposerItem::ComposerPicture:
    sipClass = sipClass_QgsComposerPicture;
    *sipCppRet = static_cast<QgsComposerPicture*>(sipCpp);
    break;
  case QgsComposerItem::ComposerScaleBar:
    sipClass = sipClass_QgsComposerScaleBar;
    *sipCppRet = static_cast<QgsComposerScaleBar*>(sipCpp);
    break;
  case QgsComposerItem::ComposerShape:
    sipClass = sipClass_QgsComposerShape;
    *sipCppRet = static_cast<QgsComposerShape*>(sipCpp);
    break;
  case QgsComposerItem::ComposerTable:
    sipClass = sipClass_QgsComposerTable;
    *sipCppRet = static_cast<QgsComposerTable*>(sipCpp);
    break;
  case QgsComposerItem::ComposerAttributeTable:
    sipClass = sipClass_QgsComposerAttributeTable;
    *sipCppRet = static_cast<QgsComposerAttributeTable*>(sipCpp);
    break;
/*
  case QgsComposerItem::ComposerTextTable:
    sipClass = sipClass_QgsComposerTextTable;
    *sipCppRet = static_cast<QgsComposerTextTable*>(sipCpp);
    break;
*/
  default:
    sipClass = 0;
  }
%End

  public:

    enum ItemType
    {
      // base class for the items
      ComposerItem = 65636, /* UserType + 100 ... SIP does not do arithmetic */

      // derived classes
      ComposerArrow,
      ComposerItemGroup,
      ComposerLabel,
      ComposerLegend,
      ComposerMap,
      ComposerPaper,  // QgsPaperItem
      ComposerPicture,
      ComposerScaleBar,
      ComposerShape,
      ComposerTable,
      ComposerAttributeTable,
      ComposerTextTable,
      ComposerFrame
    };

    /**Describes the action (move or resize in different directon) to be done during mouse move*/
    enum MouseMoveAction
    {
      MoveItem,
      ResizeUp,
      ResizeDown,
      ResizeLeft,
      ResizeRight,
      ResizeLeftUp,
      ResizeRightUp,
      ResizeLeftDown,
      ResizeRightDown,
      NoAction
    };

    enum ItemPositionMode
    {
      UpperLeft,
      UpperMiddle,
      UpperRight,
      MiddleLeft,
      Middle,
      MiddleRight,
      LowerLeft,
      LowerMiddle,
      LowerRight
    };

    /**Constructor
     @param composition parent composition
     @param manageZValue true if the z-Value of this object should be managed by mComposition*/
    QgsComposerItem( QgsComposition* composition /TransferThis/, bool manageZValue = true );
    /**Constructor with box position and composer object
     @param x x coordinate of item
     @param y y coordinate of item
     @param width width of item
     @param height height of item
     @param composition parent composition
     @param manageZValue true if the z-Value of this object should be managed by mComposition*/
    QgsComposerItem( qreal x, qreal y, qreal width, qreal height, QgsComposition* composition /TransferThis/, bool manageZValue = true );
    virtual ~QgsComposerItem();

    /** return correct graphics item type. Added in v1.7 */
    virtual int type() const;

    /** \brief Set selected, selected item should be highlighted */
    virtual void setSelected( bool s );

    /** \brief Is selected */
    virtual bool selected() const;

    /** stores state in project */
    virtual bool writeSettings();

    /** read state from project */
    virtual bool readSettings();

    /** delete settings from project file  */
    virtual bool removeSettings();

    /**Moves item in canvas coordinates*/
    void move( double dx, double dy );

    /**Move Content of item. Does nothing per default (but implemented in composer map)
       @param dx move in x-direction (canvas coordinates)
       @param dy move in y-direction(canvas coordinates)*/
    virtual void moveContent( double dx, double dy );

    /**Zoom content of item. Does nothing per default (but implemented in composer map)
     @param delta value from wheel event that describes magnitude and direction (positive /negative number)
    @param x x-position of mouse cursor (in item coordinates)
    @param y y-position of mouse cursor (in item coordinates)*/
    virtual void zoomContent( int delta, double x, double y );

    /**Moves the item to a new position (in canvas coordinates)*/
    void setItemPosition( double x, double y, ItemPositionMode itemPoint = UpperLeft );

    /**Sets item position and width / height in one go
     * @param posIncludesFrame set to true if the position and size arguments include the item's frame border
      @note: this method was added in version 1.6*/
    void setItemPosition( double x, double y, double width, double height, ItemPositionMode itemPoint = UpperLeft, bool posIncludesFrame = false );

    /**Returns item's last used position mode.
      @note: This property has no effect on actual's item position, which is always the top-left corner.
      @note: this method was added in version 2.0*/
    ItemPositionMode lastUsedPositionMode();

    /**Sets this items bound in scene coordinates such that 1 item size units
     corresponds to 1 scene size unit*/
    virtual void setSceneRect( const QRectF& rectangle );

    /** stores state in Dom element
     * @param elem is Dom element corresponding to 'Composer' tag
     * @param doc is the Dom document
     */
    virtual bool writeXML( QDomElement& elem, QDomDocument & doc ) const = 0;

    /**Writes parameter that are not subclass specific in document. Usually called from writeXML methods of subclasses*/
    bool _writeXML( QDomElement& itemElem, QDomDocument& doc ) const;

    /** sets state from Dom document
     * @param itemElem is Dom node corresponding to item tag
     * @param doc is Dom document
     */
    virtual bool readXML( const QDomElement& itemElem, const QDomDocument& doc ) = 0;

    /**Reads parameter that are not subclass specific in document. Usually called from readXML methods of subclasses*/
    bool _readXML( const QDomElement& itemElem, const QDomDocument& doc );

    /** Whether this item has a frame or not.
     * @returns true if there is a frame around this item, otherwise false.
     * @note introduced since 1.8
     * @see hasFrame
     */
    bool hasFrame() const;

    /** Set whether this item has a frame drawn around it or not.
     * @param drawFrame draw frame
     * @returns nothing
     * @note introduced in 1.8
     * @see hasFrame
     */
    void setFrameEnabled( bool drawFrame );

    /** Sets frame outline width
     * @param outlineWidth new width for outline frame
     * @returns nothing
     * @note introduced in 2.2
     * @see setFrameEnabled
     */
    virtual void setFrameOutlineWidth( double outlineWidth );

    /** Returns the estimated amount the item's frame bleeds outside the item's
     *  actual rectangle. For instance, if the item has a 2mm frame outline, then
     *  1mm of this frame is drawn outside the item's rect. In this case the
     *  return value will be 1.0
     * @note introduced in 2.2
     */
    virtual double estimatedFrameBleed() const;

    /** Returns the item's rectangular bounds, including any bleed caused by the item's frame.
     *  The bounds are returned in the item's coordinate system (see Qt's QGraphicsItem docs for
     *  more details about QGraphicsItem coordinate systems). The results differ from Qt's rect()
     *  function, as rect() makes no allowances for the portion of outlines which are drawn
     *  outside of the item.
     * @note introduced in 2.2
     * @see estimatedFrameBleed
     */
    virtual QRectF rectWithFrame() const;

    /** Whether this item has a Background or not.
     * @returns true if there is a Background around this item, otherwise false.
     * @note introduced since 2.0
     * @see hasBackground
     */
    bool hasBackground() const;

    /** Set whether this item has a Background drawn around it or not.
     * @param drawBackground draw Background
     * @returns nothing
     * @note introduced in 2.0
     * @see hasBackground
     */
    void setBackgroundEnabled( bool drawBackground );

    /** Gets the background color for this item
     * @returns background color
     * @note introduced in 2.0
     */
    QColor backgroundColor() const;

    /** Sets the background color for this item
     * @param backgroundColor new background color
     * @returns nothing
     * @note introduced in 2.0
     */
    void setBackgroundColor( const QColor& backgroundColor );

    /** Returns the item's composition blending mode */
    QPainter::CompositionMode blendMode() const;

    /** Sets the item's composition blending mode*/
    void setBlendMode( QPainter::CompositionMode blendMode );

    /** Returns the item's transparency */
    int transparency() const;
    /** Sets the item's transparency */
    void setTransparency( int transparency );

    /** Returns true if effects (eg blend modes) are enabled for the item
     * @note introduced in 2.0
    */
    bool effectsEnabled() const;
    /** Sets whether effects (eg blend modes) are enabled for the item
     * @note introduced in 2.0
    */
    void setEffectsEnabled( bool effectsEnabled );

    /**Composite operations for item groups do nothing per default*/
    virtual void addItem( QgsComposerItem* item );
    virtual void removeItems();

    const QgsComposition* composition() const;

    virtual void beginItemCommand( const QString& text );

    /**Starts new composer undo command
      @param commandText command title
      @param c context for mergeable commands (unknown for non-mergeable commands*/
    void beginCommand( const QString& commandText, QgsComposerMergeCommand::Context c = QgsComposerMergeCommand::Unknown );

    virtual void endItemCommand();
    /**Finish current command and push it onto the undo stack */
    void endCommand();
    void cancelCommand();

    //functions that encapsulate the workaround for the Qt font bug (that is to scale the font size up and then scale the
    //painter down by the same factor for drawing

    /**Draws Text. Takes care about all the composer specific issues (calculation to pixel, scaling of font and painter
     to work around the Qt font bug)*/
    void drawText( QPainter* p, double x, double y, const QString& text, const QFont& font ) const;

    /**Like the above, but with a rectangle for multiline text*/
    void drawText( QPainter* p, const QRectF& rect, const QString& text, const QFont& font, Qt::AlignmentFlag halignment = Qt::AlignLeft, Qt::AlignmentFlag valignment = Qt::AlignTop ) const;

    /**Returns the font width in millimeters (considers upscaling and downscaling with FONT_WORKAROUND_SCALE*/
    double textWidthMillimeters( const QFont& font, const QString& text ) const;

    /**Returns the font height of a character in millimeters
      @note this method was added in version 1.7*/
    double fontHeightCharacterMM( const QFont& font, const QChar& c ) const;

    /**Returns the font ascent in Millimeters (considers upscaling and downscaling with FONT_WORKAROUND_SCALE*/
    double fontAscentMillimeters( const QFont& font ) const;

    /**Returns the font ascent in Millimeters (considers upscaling and downscaling with FONT_WORKAROUND_SCALE*/
    double fontDescentMillimeters( const QFont& font ) const;

    /**Calculates font to from point size to pixel size*/
    double pixelFontSize( double pointSize ) const;

    /**Returns a font where size is in pixel and font size is upscaled with FONT_WORKAROUND_SCALE*/
    QFont scaledFontPixelSize( const QFont& font ) const;

    /**Locks / unlocks the item position for mouse drags
    @note this method was added in version 1.2*/
    void setPositionLock( bool lock );

    /**Returns position lock for mouse drags (true means locked)
    @note this method was added in version 1.2*/
    bool positionLock() const;

    /**Returns the rotation for the composer item
    @note this method was added in version 2.1*/
    double itemRotation() const;

    /**Returns the rotation for the composer item
     * @deprecated Use itemRotation()
     *             instead
     */
    double rotation() const;

    /**Updates item, with the possibility to do custom update for subclasses*/
    virtual void updateItem();

    /**Get item's id (which is not necessarly unique)
      @note this method was added in version 1.7*/
    QString id() const;

    /**Set item's id (which is not necessarly unique)
      @note this method was added in version 1.7*/
    void setId( const QString& id );

    /**Get item identification name
      @note this method was added in version 2.0
      @note there is not setter since one can't manually set the id*/
    QString uuid() const;

  public slots:
    /**Sets the item rotation
     * @deprecated Use setItemRotation( double rotation ) instead
     */
    virtual void setRotation( double r );

    /**Sets the item rotation
      @param r item rotation in degrees
      @param adjustPosition set to true if item should be shifted so that rotation occurs
       around item center. If false, rotation occurs around item origin
      @note this method was added in version 2.1
    */
    virtual void setItemRotation( double r, bool adjustPosition = false );

    void repaint();

  protected:

    //event handlers
    virtual void mouseMoveEvent( QGraphicsSceneMouseEvent * event );
    virtual void mousePressEvent( QGraphicsSceneMouseEvent * event );
    virtual void mouseReleaseEvent( QGraphicsSceneMouseEvent * event );

    virtual void hoverMoveEvent( QGraphicsSceneHoverEvent * event );

    /**Draw selection boxes around item*/
    virtual void drawSelectionBoxes( QPainter* p );

    /**Draw black frame around item*/
    virtual void drawFrame( QPainter* p );

    /**Draw background*/
    virtual void drawBackground( QPainter* p );

    /**Draws arrowhead*/
    void drawArrowHead( QPainter* p, double x, double y, double angle, double arrowHeadWidth ) const;

    /**Returns angle of the line from p1 to p2 (clockwise, starting at N)*/
    double angle( const QPointF& p1, const QPointF& p2 ) const;

    /**Returns the current (zoom level dependent) tolerance to decide if mouse position is close enough to the
    item border for resizing*/
    double rectHandlerBorderTolerance() const;

    /**Returns the size of the lock symbol depending on the composer zoom level and the item size
    @note: this function was introduced in version 1.2*/
    double lockSymbolSize() const;

    /**Returns the zoom factor of the graphics view.
      @return the factor or -1 in case of error (e.g. graphic view does not exist)
    @note: this function was introduced in version 1.2*/
    double horizontalViewScaleFactor() const;

    //some utility functions

    /**Calculates width and hight of the picture (in mm) such that it fits into the item frame with the given rotation*/
    bool imageSizeConsideringRotation( double& width, double& height, double rotation ) const;
    /**Calculates width and hight of the picture (in mm) such that it fits into the item frame with the given rotation
     * @deprecated Use bool imageSizeConsideringRotation( double& width, double& height, double rotation )
     * instead
     */
    bool imageSizeConsideringRotation( double& width, double& height ) const;

    /**Calculates the largest scaled version of originalRect which fits within boundsRect, when it is rotated by
     * a specified amount
        @param originalRect QRectF to be rotated and scaled
        @param boundsRect QRectF specifying the bounds which the rotated and scaled rectangle must fit within
        @param rotation the rotation in degrees to be applied to the rectangle
    */
    QRectF largestRotatedRectWithinBounds( QRectF originalRect, QRectF boundsRect, double rotation ) const;

    /**Calculates corner point after rotation and scaling*/
    bool cornerPointOnRotatedAndScaledRect( double& x, double& y, double width, double height, double rotation ) const;
    /**Calculates corner point after rotation and scaling
     * @deprecated Use bool cornerPointOnRotatedAndScaledRect( double& x, double& y, double width, double height, double rotation )
     * instead
     */
    bool cornerPointOnRotatedAndScaledRect( double& x, double& y, double width, double height ) const;

    /**Calculates width / height of the bounding box of a rotated rectangle*/
    void sizeChangedByRotation( double& width, double& height, double rotation );
    /**Calculates width / height of the bounding box of a rotated rectangle
    * @deprecated Use void sizeChangedByRotation( double& width, double& height, double rotation )
    * instead
    */
    void sizeChangedByRotation( double& width, double& height );

    /**Rotates a point / vector
        @param angle rotation angle in degrees, counterclockwise
        @param x in/out: x coordinate before / after the rotation
        @param y in/out: y cooreinate before / after the rotation*/
    void rotate( double angle, double& x, double& y ) const;

    /**Return horizontal align snap item. Creates a new graphics line if 0*/
    QGraphicsLineItem* hAlignSnapItem();
    void deleteHAlignSnapItem();
    /**Return vertical align snap item. Creates a new graphics line if 0*/
    QGraphicsLineItem* vAlignSnapItem();
    void deleteVAlignSnapItem();
    void deleteAlignItems();

  signals:
    /**Is emitted on item rotation change*/
    void itemRotationChanged( double newRotation );
    /**Used e.g. by the item widgets to update the gui elements*/
    void itemChanged();
    /**Emitted if the rectangle changes*/
    void sizeChanged();
    /**Emitted if the item's frame style changes
     * @note: this function was introduced in version 2.2
    */
    void frameChanged();

};
