<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:page="http://benad.me/schema/page"
    xmlns:html="http://www.w3.org/TR/xhtml1/strict"
    version="1.0">
                    
    <xsl:output method="xml" media-type="text/xhtml" indent="yes" omit-xml-declaration="yes"
    encoding="utf-8"
                doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="page:page">
        <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
        <head>
            <meta http-equiv="content-type" content="text/xhtml; charset=utf-8"/>
            <title><xsl:value-of select="page:head/page:title"/></title>
            <xsl:apply-templates select="page:head/page:meta/html:*"/>
        </head>
        <body>
            <h2><xsl:value-of select="page:head/page:title"/></h2>
            <xsl:apply-templates select="page:body/page:section"/>
        </body>
        </html>
    </xsl:template>
    
    <xsl:template match="page:section">
        <xsl:if test="@title">
        <h3 xmlns="http://www.w3.org/1999/xhtml"><xsl:value-of select="@title"/></h3>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="page:subsection">
        <xsl:if test="@title">
        <h4 xmlns="http://www.w3.org/1999/xhtml">
        <xsl:choose>
        <xsl:when test="@href">
        <xsl:element name="a">
        <xsl:attribute name="href">
        <xsl:value-of select="@href"/>
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
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="page:a">
        <xsl:element name="a" xmlns="http://www.w3.org/1999/xhtml">
        <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
        <xsl:if test="@title">
        <xsl:attribute name="title"><xsl:value-of select="@title"/></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="page:b">
        <b xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates/></b>
    </xsl:template>
    
    <xsl:template match="page:i">
        <i xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates/></i>
    </xsl:template>
    
    <xsl:template match="html:*">
        <xsl:element name="{local-name()}" xmlns="http://www.w3.org/1999/xhtml">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
