-- Concept: SELECT, FROM, WHERE, DISTINCT--
-- * List all tracks and their unit prices. --
select TrackId,name, Composer FROM track



-- Find all customers from a specific country (e.g., Brazil). --
select * from customer
 WHERE Country = 'Brazil'



--Get a list of all unique billing countries from the Invoice table. --
SELECT DISTINCT `BillingCountry`  from invoice



/* Find all tracks that do not have a composer listed, and sort 
them by  their Name in alphabetical order. */
SELECT TrackId,track.Name from track
where Composer is NULL




-- Concept: INNER JOIN, LEFT JOIN, Multiple Joins.
-- List every track name alongside its Genre ands Media Type. --
SELECT track.name, genre.name, mediatype.name from track
inner join genre on track.GenreId = genre.GenreId
inner join mediatype on track.MediaTypeId = mediatype.MediaTypeId



/* Generate a list of all invoices showing the Customer's 
name and the Employee (Sales Support Rep) who helped them. */
SELECT invoice.invoiceId, customer.FirstName, employee.FirstName from invoice
inner join customer on invoice.CustomerId = customer.CustomerId 
inner JOIN employee on  employee.EmployeeId = customer.SupportRepId



-- List all Playlists and the total number of Tracks contained in each. --
SELECT playlist.Name, COUNT(track.Name) as Total from playlist
inner join playlisttrack on playlist.PlaylistId = playlisttrack.PlaylistId
inner JOIN track on playlisttrack.TrackId = track.TrackId
GROUP BY playlist.Name




-- Concept: GROUP BY, COUNT(), SUM(), ORDER BY, LIMIT
-- Who are the top 5 customers based on total spending? --
SELECT customer.CustomerId, customer.FirstName, customer.LastName, SUM(invoice.Total) AS Total
FROM customer
INNER JOIN invoice ON invoice.CustomerId = customer.CustomerId
GROUP BY customer.CustomerId, customer.FirstName, customer.LastName
ORDER BY Total DESC
LIMIT 5



-- Which Sales Agent has the highest total sales in 2025? --
SELECT employee.EmployeeId, employee.FirstName, employee.LastName, SUM(invoice.Total) as total 
FROM employee
INNER JOIN  customer on  employee.EmployeeId = customer.SupportRepId 
INNER JOIN  invoice on  customer.customerId = invoice.customerId
GROUP BY employee.EmployeeId, employee.FirstName, employee.LastName
ORDER BY total DESC
limit 1



/* Which Country has the highest average invoice total? Only 
include countries that have more than 5 invoices. */
SELECT invoice.BillingCountry, AVG(invoice.Total) as total from invoice
GROUP BY invoice.BillingCountry
HAVING COUNT(InvoiceId) > 5
ORDER BY total DESC
LIMIT 1
 