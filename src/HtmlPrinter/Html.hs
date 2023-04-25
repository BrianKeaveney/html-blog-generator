-- Html.hs

module HtmlPrinter.Html
  ( Html,
    Head,
    title_,
    stylesheet_,
    meta_,
    Structure,
    html_,
    p_,
    h_,
    ul_,
    ol_,
    code_,
    Content,
    txt_,
    img_,
    link_,
    b_,
    i_,
    render,
  )
where

import HtmlPrinter.Html.Internal
import Prelude hiding (head)
