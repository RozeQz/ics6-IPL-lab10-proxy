<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<HTML>
<HEAD>
  <TITLE>Преобзразование XML</TITLE>
  <META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <LINK href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
</HEAD>
<BODY>
<H1>Palindromes</H1>
<xsl:if test="output/input">
  <P>Вы ввели: <xsl:value-of select="output/input"/></P>
</xsl:if>
<xsl:choose>
<xsl:when test="output/error">
  <P class="text-danger">Ошибка: <xsl:value-of select="output/error"/></P>
</xsl:when>
<xsl:otherwise>
  <P>Ответ: <xsl:value-of select="output/result"/></P>
  <TABLE class="table table-striped">
      <TR>
          <TH scope="col">#</TH>
          <TH scope="col">Число</TH>
          <TH scope="col">Квадрат числа</TH>
      </TR>
      <xsl:for-each select="output/table/palindrome">
      <TR>
          <TD scope="row"><xsl:value-of select="output/table/palindrome/index"/></TD>
          <TD scope="row"><xsl:value-of select="output/table/palindrome/number"/></TD>
          <TD scope="row"><xsl:value-of select="output/table/palindrome/square"/></TD>
      </TR>
      </xsl:for-each>
  </TABLE><BR/>
</xsl:otherwise>
</xsl:choose>
<BUTTON type="button" class="btn btn-link">
  <A href="/">Вернуться</A>
</BUTTON>
</BODY>
</HTML>

</xsl:template>
</xsl:stylesheet>