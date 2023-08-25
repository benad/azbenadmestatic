<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:page="http://benad.me/schema/page"
    xmlns:html="http://www.w3.org/TR/xhtml1/strict"
    exclude-result-prefixes="html page"
    version="1.0">
                    
    <xsl:output encoding="utf-8" indent="yes" method="html" omit-xml-declaration="yes"/>
    
    <xsl:template match="page:page">
    	<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>
&lt;!--[if lt IE 7]>      &lt;html class="no-js lt-ie9 lt-ie8 lt-ie7"> &lt;![endif]-->
&lt;!--[if IE 7]>         &lt;html class="no-js lt-ie9 lt-ie8"> &lt;![endif]-->
&lt;!--[if IE 8]>         &lt;html class="no-js lt-ie9"> &lt;![endif]-->
&lt;!--[if gt IE 8]>&lt;!--> </xsl:text>
    <html class="no-js">
        <xsl:text disable-output-escaping="yes"> &lt;!--&lt;![endif]-->
</xsl:text>
        <head>
            <meta charset="utf-8"/>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
            <title><xsl:if test="page:head/page:title"><xsl:value-of select="page:head/page:title"/> - </xsl:if>Benad's Web Site</title>
            <meta name="description" content=""/>
            <meta name="viewport" content="width=device-width"/>
            <link rel="stylesheet" href="/css/bootstrap.css"/>
            <link rel="stylesheet" href="/css/bootstrap-responsive.css"/>
            <link rel="stylesheet" href="/css/main.css"/>
            <link rel="me" href="https://micro.blog/benad"/>
            <script src="/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
            <xsl:apply-templates select="page:head/page:meta/html:*"/>
        </head>
        <body>
            <xsl:text disable-output-escaping="yes">&lt;!--[if lt IE 7]>
            &lt;p class="chromeframe">You are using an &lt;strong>outdated&lt;/strong> browser. Please &lt;a href="https://browsehappy.com/">upgrade your browser&lt;/a> to improve your experience.&lt;/p>
        &lt;![endif]-->
    </xsl:text>
            <div class="container">
                <div class="row">
                    <xsl:choose>
                    <xsl:when test="page:head/page:title">
                        <h1 class="title">Benad's Web Site</h1>
                        <h2 class="pageheader"><xsl:value-of select="page:head/page:title"/></h2>
                    </xsl:when>
                    <xsl:otherwise>
                        <h1 class="title">Benad's Web Site</h1>
                    </xsl:otherwise>
                    </xsl:choose>
                </div>
                <div class="row">
                    <div class="span2 pull-right sidebar">
                        <p><a href="/index.html">Home</a></p>
                        <p><a href="/blog">Blog</a></p>
                        <p><a href="/me.html">About Me</a></p>
                        <p><a href="/meta.html">About This Site</a></p>
                        <p><a href="/articles.html">Articles</a></p>
                        <p><a href="/links.html">Links</a></p>
                    </div>
                    <div class="span8 offset2">
                        <xsl:apply-templates select="page:body/page:section"/>
                    </div>
                </div>
                <footer>
                    <hr/>
                    <p>Benad's Web Site by Benoit Nadeau is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a></p>
		            <p>Mastodon: <a rel="me" href="https://mstdn.ca/@benad">@benad@mstdn.ca</a></p>
                </footer>
            </div>
            <script src="/js/vendor/jquery-1.9.1.min.js"></script>
            <script src="/js/vendor/bootstrap.min.js"></script>
            <script src="/js/main.js"></script>
        </body>
    </html>
    </xsl:template>
    
    <xsl:template match="page:section">
        <xsl:if test="@title">
        <h3><xsl:value-of select="@title"/></h3>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="page:subsection">
        <xsl:if test="@title">
        <h4>
        <xsl:choose>
        <xsl:when test="@href">
        <xsl:element name="a">
        <xsl:attribute name="href">
        <xsl:value-of select="replace(@href, '^([^/]+)\.xml$', '$1.html')"/>
        </xsl:attribute>
        <xsl:value-of select="@title"/>
        </xsl:element>
        </xsl:when>
        <xsl:otherwise>
        <xsl:value-of select="@title"/>
        </xsl:otherwise>
        </xsl:choose>
        </h4>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="page:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="page:a">
        <xsl:element name="a">
        <xsl:attribute name="href"><xsl:value-of select="replace(@href, '^([^/]+)\.xml$', '$1.html')"/></xsl:attribute>
        <xsl:if test="@title">
        <xsl:attribute name="title"><xsl:value-of select="@title"/></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="page:b">
        <b><xsl:apply-templates/></b>
    </xsl:template>
    
    <xsl:template match="page:i">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    <xsl:template match="page:tt">
        <code><xsl:apply-templates/></code>
    </xsl:template>

    <xsl:template match="page:codeblock">
        <xsl:element name="pre">
        <xsl:attribute name="name">code</xsl:attribute>
        <code>
        <xsl:apply-templates/>
        </code>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="page:img">
        <xsl:element name="div">
            <xsl:attribute name="style">text-align: center</xsl:attribute>
            <xsl:element name="img">
                <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="@title"/></xsl:attribute>
            </xsl:element>
            <xsl:element name="br"/>
            <xsl:value-of select="@title"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="html:*">
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
