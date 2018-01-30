Sub StockDataSummary()

    Dim WorkSheetName As String
    Dim TickerName As String
    Dim prevTicker As String
    Dim TickerTotal As Double
                ' row index in summary table
    Dim lastRow As Long
    Dim SumRow As Integer
    
    For Each ws In Worksheets
        WorkSheetName = ws.Name
                lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
                SumRow = 2
                TickerTotal = 0
                ' Loop through all tickers
                
                'Debug.Print (lastRow)
                prevTicker = ws.Cells(2, 1).Value
                For I = 2 To lastRow
                  TickerName = ws.Cells(I, 1).Value
                  Debug.Print (I)
                  If TickerName = prevTicker Then
                    'Add to the Ticker Total
                    TickerTotal = TickerTotal + ws.Cells(I, 7).Value
                  Else
                    ' Print the Ticker Name in the Summary Table
                    ws.Range("I1").Cells(SumRow, 1).Value = prevTicker
                    ' Print the ticker Amount to the Summary Table
                    ws.Range("I1").Cells(SumRow, 2).Value = TickerTotal
                    ' Add one to the summary table row
                    SumRow = SumRow + 1
                    ' Start the new ticker Total
                    TickerTotal = ws.Cells(I, 7).Value
                    prevTicker = TickerName
                  End If
                  
                Next I

                 'print the last ticker's total
                 ws.Range("I1").Cells(SumRow, 1).Value = TickerName
                 ws.Range("I1").Cells(SumRow, 2).Value = TickerTotal
                 ws.Range("I1") = "Ticker Name"
                 ws.Range("J1") = "Total Volume"
                 
                

        Next ws
End Sub

